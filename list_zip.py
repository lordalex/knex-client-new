import urllib.request
import zipfile
import io

url = "https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip"
print(f"Checking content of {url}...")
try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        zip_content = response.read()
    
    with zipfile.ZipFile(io.BytesIO(zip_content)) as zip_ref:
        for file in zip_ref.namelist():
            if file.endswith(".ttf") or file.endswith(".otf"):
                print(file)
                
except Exception as e:
    print(f"Error: {e}")
