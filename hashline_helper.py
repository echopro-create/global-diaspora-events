import hashlib
import sys
import os

def get_line_hash(text):
    return hashlib.md5(text.strip().encode('utf-8')).hexdigest()[:2] if text.strip() else "00"

def process_file(file_path):
    if not os.path.isfile(file_path):
        print(f"Error: {file_path} not found.")
        return
    with open(file_path, 'r', encoding='utf-8') as f:
        for i, line in enumerate(f, 1):
            clean_line = line.rstrip('\n')
            h = get_line_hash(clean_line)
            print(f"{i}:{h}|{clean_line}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        process_file(sys.argv[1])
