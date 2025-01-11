# PowerShell script to compile and run Java programs with JADE

param (
    [string]$cmd,
    [string]$arg1
)

$JAVAC = "javac"
$JAVA = "java"
$JADE_JAR = "lib/jade.jar"
$SRC_DIR = "src"
$OUT_DIR = "classes"
$CLASSPATH = "$JADE_JAR;$OUT_DIR"

$RUN_CLASS = "Monitor"
$RUN_NAME = "Monitor"
$RUN_ARGS = ""
$numContainers = 3

function compile_src {
    Write-Output "Compiling Java code..."
    & $JAVAC -classpath $JADE_JAR -d $OUT_DIR -Xdiags:verbose -Xlint:deprecation -Xlint:unchecked "$SRC_DIR/*.java"
    Write-Output "Compilation finished."
}

function run {
    Write-Output "Running scenario..."

    $process = Start-Process -FilePath $JAVA -ArgumentList "-cp", $CLASSPATH, "jade.Boot", "-gui" -PassThru -WindowStyle Normal
    Write-Output "$containerName started (PID $($process.Id) copied to clipboard)"
    Set-Clipboard -Value $process.Id

    Start-Sleep -Seconds 5

    $containersList = ""
    for ($i = 1; $i -le $numContainers; $i++) {
        $containerName = "RunContainer$i"
        $containersList += "${containerName}@localhost,"
        $process = Start-Process -FilePath $JAVA -ArgumentList "-cp", $CLASSPATH, "jade.Boot", "-host", "localhost", "-container", "-container-name", $containerName -PassThru -WindowStyle Normal
        Write-Output "$containerName started (PID $($process.Id))"
    }

    $containersList = $containersList.TrimEnd(",")
    & $JAVA -cp $CLASSPATH jade.Boot -container -container-name ContainerRun -host localhost -agents "${RUN_CLASS}:$RUN_NAME($containersList)"
    # & $JAVA -cp $CLASSPATH jade.Boot -gui -host localhost -agents "${RUN_CLASS}:$RUN_NAME($containersList)"
}

function spawn_gui {
    Write-Output "Starting JADE with GUI..."
    & $JAVA -cp $CLASSPATH jade.Boot -gui
}

function spawn_agent {
    Write-Output "Starting JADE agent on Windows with agent name '$agentName'..."
    & $JAVA -cp $CLASSPATH jade.Boot -host localhost -agents "${RUN_CLASS}:$RUN_NAME($RUN_ARGS)"
}

function spawn_container {
    Write-Output "Starting JADE container..."
    $process = Start-Process -FilePath $JAVA -ArgumentList "-cp", $CLASSPATH, "jade.Boot", "-host", "localhost", "-container" -PassThru -WindowStyle Normal
    Write-Output "Container startetd (PID $($process.Id))"
}

switch ($cmd) {
    "compile" { compile_src }
    "gui" { spawn_gui }
    "agent" { spawn_agent }
    "container" { spawn_container }
    "run" { run }
    default { Write-Output "Usage: .\jade.ps1 <compile|gui|agent|container|run> [cmd_arg]" }
}
