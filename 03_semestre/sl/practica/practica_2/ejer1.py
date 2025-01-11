from urllib import request

README_URL = 'https://raw.githubusercontent.com/numpy/numpy/main/README.md'

page = request.urlopen(README_URL)

content_as_string = page.read().decode('utf-8')

def main():
    lines = content_as_string.split('\n')
    
    lines_with_links = filter(lambda string : 'http' in string, lines)
    
    for line in lines_with_links:
        print(line)

if __name__ == '__main__':
    main()
