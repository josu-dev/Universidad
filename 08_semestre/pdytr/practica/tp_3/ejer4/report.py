import os
import pandas as pd

# Path to the logs directory
LOGS_DIR = "logs"

# Define the structure of the log file columns
columns = ["timestamp", "message_index", "duration_for_transmission"]

def process_log_file(log_file):
    """
    Process an individual log file, extracting the timestamp, message_index, and duration.
    Returns a DataFrame.
    """
    try:
        df = pd.read_csv(log_file, names=columns)
        return df
    except Exception as e:
        print(f"Error processing {log_file}: {e}")
        return pd.DataFrame(columns=columns)

def summarize_for_client_size(client_size):
    """
    For a given client size, aggregate data across all message sizes and produce CSV summaries.
    """
    client_dir = os.path.join(LOGS_DIR, str(client_size))
    summary_data = {}

    # Traverse through all message sizes
    for message_size in os.listdir(client_dir):
        message_size_dir = os.path.join(client_dir, message_size, "client")
        message_size = int(message_size)  # Convert to integer to use as column header
        
        all_logs_data = pd.DataFrame(columns=columns)

        # Process each client's log file
        for log_file in os.listdir(message_size_dir):
            if log_file.endswith("_out.log"):
                log_path = os.path.join(message_size_dir, log_file)
                log_df = process_log_file(log_path)
                
                # Only concatenate non-empty DataFrames
                if all_logs_data.empty:
                    all_logs_data[columns] = log_df
                else:
                    all_logs_data = pd.concat([all_logs_data, log_df], ignore_index=True)

        if all_logs_data.empty:
            print(f"No valid data found for client size {client_size} and message size {message_size}.")
            continue

        # Calculate the average for each message_index for this message size
        avg_data = all_logs_data.groupby("message_index")["duration_for_transmission"].median()
        summary_data[message_size] = avg_data

    # Create a DataFrame to summarize data
    summary_df = pd.DataFrame(summary_data)

    # Ensure message_index is part of the DataFrame (indexed by default by groupby)
    summary_df.reset_index(inplace=True)
    
    # Save the summarized data as a CSV file
    avg_csv_path = os.path.join(LOGS_DIR, f"{client_size}_avg.csv")
    summary_df.to_csv(avg_csv_path, index=False)
    print(f"Average summary saved for client size {client_size} at {avg_csv_path}")

def main():
    # Traverse the logs directory for each client size
    for client_size in os.listdir(LOGS_DIR):
        client_size_path = os.path.join(LOGS_DIR, client_size)
        
        if os.path.isdir(client_size_path) and client_size.isdigit():
            print(f"Processing logs for client size {client_size}...")
            summarize_for_client_size(client_size)

if __name__ == "__main__":
    main()
