import sys
import requests

API_URL = "https://jgiquality.qualer.com/Sop/SaveSopFile"
SECOND_API_URL = "https://jgiquality.qualer.com/Sop/Sop"

def SaveSopFile(api_url, api_key, file_path):
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Referer': 'https://jgiquality.qualer.com/Sop/SaveSopFile?sopId=2351'
    }
    files = {'file': open(file_path, 'rb')}
    response = requests.post(api_url, headers=headers, files=files)
    return response

def Sop(api_key):
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Referer': 'https://jgiquality.qualer.com/Sop/Sop?sopId=2351'
    }
    data = {
        'SopId': '2351',
        'SopTypeId': '1544',  # Always use 1544 ("Approved Software")
        'AttachmentName': 'Form 3018, Rockwell.xlsm',
        'SopTypeName': 'Approved Software',
        'title': 'Form 3018, Rockwell Worksheet',
        'code': 'Form 3018',
        'EffectiveDate': '12/19/2024',  #FIXME: Replace this with the current date
        'revision': 'U',  #FIXME: Replace this with the current commit hash
        'author': '',  #FIXME: Add the author of the commit
        'details': '', #FIXME: Add release notes from the merge request
        '__RequestVerificationToken': 'tvsOYtTSCd6mbTVcka4HNEKXAEZxb5qo4SwBtderRXvTMID1aQ8VL6Enk0DAg_cAgd8-HnIyrBV1i1NPJ0D_WmsUQY1a3bp96uA7BWShDnkTJ92y0'  # FIXME: Get fresh token
    }
    response = requests.post(SECOND_API_URL, headers=headers, data=data)
    return response

def main():
    api_key = sys.argv[1]
    file_paths = sys.argv[2:]

    for file_path in file_paths:
        response = SaveSopFile(API_URL, api_key, file_path)
        print(f'Uploaded {file_path}: {response.status_code} - {response.text}')
    
    response = Sop(api_key)
    print(f'Second API call: {response.status_code} - {response.text}')

if __name__ == "__main__":
    main()