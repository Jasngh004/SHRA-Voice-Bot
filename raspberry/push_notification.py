import requests

# Define your OneSignal API key and app ID
API_KEY = 'OGVlNWQ2YTAtYTUxMC00YWM3LWJkNDYtMDJlYTgzNzVhYWEw'
APP_ID = 'c11a2b51-f7a4-4dcd-9b27-5d273813738d'

# Make the POST request to OneSignal API
headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Authorization": f"Basic {API_KEY}"
}

def send_notification(data):
    notification = {
    "app_id": APP_ID,
    "contents": {"en": f"Patient {data['name']} is having an emergency!! Please check in Ward Number {data['wardnum']}"},
    "headings": {"en": "Patient Emergency! High Priority"},
    "included_segments": ["All"]
    }
    response = requests.post("https://onesignal.com/api/v1/notifications", headers=headers, json=notification)
    if response.status_code == 200:
        print("Notification sent successfully!")
    else:
        print("Failed to send notification:", response.text)


# send_notification({"name": "zayn", "wardnum": 20})