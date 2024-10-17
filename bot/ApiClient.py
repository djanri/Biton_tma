import requests

class ApiClient:
    api_url = "https://localhost:3000"
    users_url = "/users"

    def user_exists(self, user_id):
        print("exists") 
        response = requests.get(self.users_url, params=user_id)
        result = False;
        if response.status_code == 200:
            print("GET-запрос успешно выполнен!")
            print(response.json())
            result = True
        else:
            print(f"Ошибка при GET-запросе: {response.status_code}")
        return result

    def add_user(self, user_id, user_name, referer_id=None):
        print("adding user")
        data = {
            "userId": user_id,
            "userName": user_name,
            "referalId": referer_id,
        }
        response = requests.post(self.users_url, json=data)
        if response.status_code == 201:
            print("POST-запрос успешно выполнен!")
        else:
            print(f"Ошибка при POST-запросе: {response.status_code}")

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
