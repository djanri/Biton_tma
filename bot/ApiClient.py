import socket

import certifi
import requests
import urllib3
from rsa.cli import verify


class ApiClient:
    api_url = "https://localhost:7000"
    users_url = f"{api_url}/users"
    http = urllib3.PoolManager(
        cert_reqs="CERT_REQUIRED",
        ca_certs="./.cert/localhost.crt"
    )

    def user_exists(self, user_id):
        print(socket.gethostbyname(socket.gethostname()))
        response = self.http.request("GET", f'{self.users_url}/userid/{user_id}')
        result = False
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            print(response.json())
            result = True
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return result

    def add_user(self, user_id, user_name, referer_id=0):
        print("adding user")
        print(f"referalId {referer_id}")
        data = {
            "userId": user_id,
            "userName": user_name,
            "referalId": 0 if referer_id == "" else referer_id
        }
        response = self.http.request("POST", self.users_url, json=data)
        print(response.status)
        if response.status == 201:
            print("POST-запрос успешно выполнен!")
        else:
            print(f"Ошибка при POST-запросе: {response.status}")

    def count_referals(self, user_id):
        print("adding user")
    
    def get_user_score(self, user_id):
        print("adding user")
        # return result[0] if result else 0

    def update_user_score(self, user_id, points):
        print("adding user")

    def get_random_user_id(self):
        print("adding user")

    def get_all_user_ids(self):
        print("adding user")
    
    async def add_prize(self, state):
        print("adding prize")
