import os
import urllib.request
import zipfile
import io
import shutil

def download_and_extract_inter():
    url = "https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip"
    print(f"Downloading Inter from {url}...")
    try:
        req = urllib.request.Request(
            url, 
            headers={'User-Agent': 'Mozilla/5.0'}
        )
        with urllib.request.urlopen(req) as response:
            zip_content = response.read()
        
        target_dir = "assets/fonts/Inter"
        os.makedirs(target_dir, exist_ok=True)
            
        with zipfile.ZipFile(io.BytesIO(zip_content)) as zip_ref:
            # Files to extract
            files_map = {
                "InterVariable.ttf": "InterVariable.ttf",
                "InterVariable-Italic.ttf": "InterVariable-Italic.ttf"
            }
            
            for zip_filename, target_filename in files_map.items():
                if zip_filename in zip_ref.namelist():
                    print(f"Found {zip_filename}")
                    source = zip_ref.open(zip_filename)
                    target_path = os.path.join(target_dir, target_filename)
                    with open(target_path, "wb") as target:
                        shutil.copyfileobj(source, target)
                    print(f"Extracted to {target_path}")
                else:
                    print(f"Could not find {zip_filename} in zip")
            
    except Exception as e:
        print(f"Error downloading Inter: {e}")

download_and_extract_inter()
