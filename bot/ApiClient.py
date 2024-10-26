import urllib3


class ApiClient:
    api_url = "https://localhost:7000"
    users_url = f"{api_url}/users"
    admins_url = f"{api_url}/admins"
    prizes_url = f"{api_url}/prizes"


    http = urllib3.PoolManager(
        cert_reqs="CERT_REQUIRED",
        ca_certs="./.cert/localhost.crt"
    )

    def user_exists(self, user_id):
        print(f"adding user: {user_id}")
        response = self.http.request("GET", f'{self.users_url}/{user_id}')
        result = False
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            result = True
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return result

    def add_user(self, user_id, user_name, referer_id=0):
        print(f"adding user: {user_id}")
        data = {
            "userId": user_id,
            "userName": user_name,
            "referalId": 0 if referer_id == "" else referer_id
        }
        response = self.http.request("POST", self.users_url, json=data)
        if response.status == 201:
            print("POST-запрос успешно выполнен!")
        else:
            print(f"Ошибка при POST-запросе: {response.status}")

    def count_referals(self, user_id):
        print(f"get referals count: {user_id}")
        response = self.http.request("GET", f'{self.users_url}/referals-count/{user_id}')
        result : int = 0
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            result = int(response.json())
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return result
    
    def get_user(self, user_id):
        print(f"get user: {user_id}")
        response = self.http.request("GET", f'{self.users_url}/{user_id}')
        user = None
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            user = response.json()
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return user

    def update_user(self, user_id, user_data):
        print(f"update user: {user_id}")
        response = self.http.request("PUT", f'{self.users_url}/{user_id}', json = user_data)
        result = False
        if response.status == 204:
            print("GET-запрос успешно выполнен!")
            result = True
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return result

    def get_random_user(self):
        print("random user")
        response = self.http.request("GET", f'{self.users_url}/random')
        user = None
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            user = response.json()
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return user

    def get_all_user_ids(self):
        print("all users")
        response = self.http.request("GET", f'{self.users_url}/ids')
        user = None
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            user = response.json()
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return user
    
    async def add_prize(self, state):
        print("adding prize")
        data = {
            "name": state['name'],
            "description": state['description'],
            "cost": state['price'],
            "image": state['photo'],
            "channelUrl": "channelUrl",
            "channelName": "channelName"
        }
        response = self.http.request("POST", self.prizes_url, json=data)

        result = False
        if response.status == 201:
            print("POST-запрос успешно выполнен!")
            result = True
        else:
            print(f"Ошибка при POST-запросе: {response.status}")
        return result

    def add_admin(self, user_id, user_name, channel_url):
        print(f"adding admin: {user_id}")
        data = {
            "userId": user_id,
            "userName": user_name,
            "channelUrl": channel_url
        }
        response = self.http.request("POST", self.admins_url, json=data)

        result = False
        if response.status == 201:
            print("POST-запрос успешно выполнен!")
            result = True
        else:
            print(f"Ошибка при POST-запросе: {response.status}")
        return result

    def delete_admin(self, user_name):
        print(f"deleting admin: {user_name}")
        response = self.http.request("DELETE", f"{self.admins_url}/{user_name}")
        result = False
        if response.status == 204:
            print("DELETE-запрос успешно выполнен!")
            result = True
        else:
            print(f"Ошибка при DELETE-запросе: {response.status}")
        return result

    def exist_admin(self, user_id):
        print(f"checking admin is exist")
        response = self.http.request("GET", f"{self.admins_url}/{user_id}")
        result = False
        if response.status == 200:
            print("GET-запрос успешно выполнен!")
            result = True
        else:
            print(f"Ошибка при GET-запросе: {response.status}")
        return result