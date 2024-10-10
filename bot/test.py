import asyncio
from reaktion import reaction
from aiogram import Bot, Dispatcher, executor, types
from aiogram.types.web_app_info import WebAppInfo
from aiogram.dispatcher.filters.state import State, StatesGroup
from aiogram.dispatcher import FSMContext
from aiogram.contrib.fsm_storage.memory import MemoryStorage
from aiogram.dispatcher.filters.state import State, StatesGroup
from aiogram.dispatcher import FSMContext
import keyboard as krb
from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup
import config as cf
# import database as db  # Убрали взаимодействие с базой данных
# from database import DataBase  # Убрали взаимодействие с базой данных
import os
from datetime import datetime, timedelta
from collections import defaultdict
# import sqlite3  # Убрали взаимодействие с базой данных
from aiogram import Bot, Dispatcher, executor, types
from aiogram.dispatcher import FSMContext
from aiogram.contrib.fsm_storage.memory import MemoryStorage
from aiogram.utils.exceptions import ChatNotFound, BadRequest
import logging
import requests
import time
import aiohttp


BOT_TOKEN = '7061940889:AAHwuc8VIAg2CPAQAel9g-XdJR9Lo8_X4mc'

# Функция для добавления плохих слов
def load_bad_words(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.text.splitlines()
    else:
        print(f"Не удалось загрузить файл. Статус код: {response.status_code}")
        return []


# Константы
POINTS_PER_COMMENT = 1
MAX_COMMENTS_PER_DAY = 3

user_data = defaultdict(lambda: {'points': 0, 'comments': 0, 'last_comment_time': datetime.now()})
logging.basicConfig(level=logging.INFO)

bot = Bot(token=BOT_TOKEN)
storage = MemoryStorage()
dp = Dispatcher(bot, storage=storage)

user_scores = {}

bad_words_url = "https://www.cs.cmu.edu/~biglou/resources/bad-words.txt"
bad_words = load_bad_words(bad_words_url)

Chanel_id = "-1002208916163"
Chanel2_id = "-1002154835852"
Not_Sub_Message = "Для доступа к функционалу, пожалуйста подпишитесь на канал!"
storage = MemoryStorage()

# Закомментировано взаимодействие с базой данных
# db_path = os.path.join('database', 'users.db')
# db1 = DataBase(db_path)

async def check_subscriptions(user_id, channel_ids):
    subscriptions = []
    for channel_id in channel_ids:
        member = await bot.get_chat_member(chat_id=channel_id, user_id=user_id)
        subscriptions.append(chek_chanel(member))
    return all(subscriptions)

async def on_startup(_):
    # await db.db_start()  # Убрали вызов инициализации базы данных
    print('Бот успешно запущен!')

# Классы для FSM
class NewOrder(StatesGroup):
    name = State()
    price = State()
    photo = State()

class CancelOrder(StatesGroup):
    cancel = State()


# Проверка подписки
def chek_chanel(chat_member):
    if chat_member['status'] != 'left':
        return True
    else:
        return False

def creater(chat_member):
    if chat_member['status'] == "creator":
        return True
    else:
        return False


# Хэндлеры
@dp.message_handler(commands=['start'])
async def start(message: types.Message):
    global user_id
    user_id = message.from_user.id
    user_name = message.from_user.first_name
    user_last_name = message.from_user.last_name
    full_name = f'{user_name} {user_last_name}' if user_last_name else user_name

    chat_member = await bot.get_chat_member(chat_id=Chanel_id, user_id=message.from_user.id)
    if chek_chanel(chat_member):
        # Логика взаимодействия с базой данных убрана
        await message.answer(f'Привет, {full_name}\nДобро пожаловать в TGplay!', reply_markup=krb.create_keyboard(user_id))
    else:
        await bot.send_message(message.from_user.id, Not_Sub_Message, reply_markup=krb.My_Chanel)

@dp.message_handler(commands=['admin'])
async def start(message: types.Message):
    if creater(await bot.get_chat_member(chat_id=Chanel_id, user_id=message.from_user.id)):
        await message.answer("Успешный вход в админ панель✅")
        await message.answer("Чтобы добавить приз нажмите на сит фразу /admin_1_get_users\nЧтобы вернуться в меню /start")
    else:
        await message.answer("Вы не являетесь владельцем канала(")

@dp.message_handler(commands=['admin_1_get_users'])
async def start(message: types.Message):
    await message.answer("Давайте добавим приз!\nВведите название ", reply_markup=krb.cancel_keyboard())
    await NewOrder.next()

@dp.message_handler(commands=['my_admin_panel'])
async def start(message: types.Message):
    if message.from_user.id==765843635 or message.from_user.id ==504035257:
        await message.answer("Добро пожаловать в панель Супер-Админа 🦸")
        await message.answer("Выберите действие:" , reply_markup=krb.Super)
    else:
        await message.answer("Вы не являетесь супер-админом")



# Словарь для отслеживания комментариев пользователей
user_comments = defaultdict(list)

@dp.message_handler(content_types=types.ContentTypes.TEXT)
async def handle_message(message: types.Message):
    user_name = message.from_user.first_name
    user_last_name = message.from_user.last_name
    full_name = f'{user_name} {user_last_name}' if user_last_name else user_name

    if message.chat.type == 'supergroup':
        user_id = message.from_user.id
        message_text = message.text.lower()

        # Логика взаимодействия с базой данных убрана
        current_score = user_data[user_id]['points']

        current_time = time.time()
        user_comments[user_id] = [timestamp for timestamp in user_comments[user_id] if current_time - timestamp <= 5 * 3600]

        if len(user_comments[user_id]) < 3:
            user_data[user_id]['points'] += 1
            current_score += 1
            user_comments[user_id].append(current_time)

            await message.answer(f'{full_name}, Ваши баллы: {current_score}')
        else:
            await message.answer(f'{full_name}, вы достигли лимита в 3 комментария за 5 часов.')

        if message_text in bad_words:
            await message.delete()
            await message.answer(f'{full_name}, в Вашем комментарии обнаружено негативное слово!\nСообщение было удалено. Ваши баллы: {current_score}')


@dp.message_handler(state=NewOrder.name)
async def start_name(message: types.Message, state: FSMContext):
    async with state.proxy() as data:
        data['name'] = message.text
    await message.answer("Введите количество баллов за приз", reply_markup=krb.cancel_keyboard())
    await NewOrder.next()

@dp.message_handler(state=NewOrder.price)
async def start_price(message: types.Message, state: FSMContext):
    async with state.proxy() as data:
        data['price'] = message.text
    await message.answer("Отправьте фото", reply_markup=krb.cancel_keyboard())
    await NewOrder.next()

@dp.message_handler(lambda message: not message.photo, state=NewOrder.photo)
async def add_item_photo_check(message: types.Message):
    await message.answer('Это не фотография!')

@dp.message_handler(content_types=['photo'], state=NewOrder.photo)
async def add_item_photo(message: types.Message, state: FSMContext):
    photo = message.photo[-1]
    file_id = photo.file_id
    file = await bot.get_file(file_id)

    way = f'/Gamefication/img/{file.file_path.split("/")[-1]}'
    await bot.download_file(file.file_path, way)

    async with state.proxy() as data:
        data['photo'] = file_id

    # Убрана логика сохранения в базу данных
    await message.answer('Приз успешно добавлен!')
    await state.finish()

@dp.callback_query_handler(text='cancel', state="*")
async def cancel_handler(callback_query: types.CallbackQuery, state: FSMContext):
    await state.finish()
    await callback_query.message.answer("Добавление отменено.")
    await callback_query.message.answer(f'Добро пожаловать в TGplay!', reply_markup=krb.create_keyboard(user_id))


# Другие хэндлеры остаются без изменений, логика взаимодействия с базой данных также убрана


# калбэки
@dp.callback_query_handler(text="sub")
async def subchanel(callback_query: types.CallbackQuery):
    user_name = callback_query.from_user.first_name
    user_last_name = callback_query.from_user.last_name
    full_name = f'{user_name} {user_last_name}' if user_last_name else user_name
    await bot.delete_message(callback_query.from_user.id, callback_query.message.message_id)

    if chek_chanel(await bot.get_chat_member(chat_id=Chanel_id, user_id=callback_query.from_user.id)):
        await bot.send_message(callback_query.from_user.id, f'Привет, {full_name}\nДобро пожаловать в TGplay!',
                               reply_markup=krb.create_keyboard(user_id))
    else:
        await bot.send_message(callback_query.from_user.id, Not_Sub_Message, reply_markup=krb.My_Chanel)


@dp.callback_query_handler(lambda query: query.data == 'more')
async def More(callback_query: types.CallbackQuery):
    await bot.delete_message(callback_query.from_user.id, callback_query.message.message_id)
    await bot.send_message(
        callback_query.from_user.id,
        "<b>TGplay: Получайте больше от подписки на канал!</b>\n\n"
        "Проявляйте активность, выполняйте дополнительные задания, "
        "копите очки и разблокируйте награды!🎁\n\n"
        "️️⚠️ Награды, их содержание и доставка являются ответственностью админов/владельцев каналов.",
        parse_mode='HTML'  # Указываем режим разметки
    )
    await bot.send_message(callback_query.from_user.id, "👌", reply_markup=krb.Back)


# реферальная система
@dp.callback_query_handler(lambda query: query.data == 'profile')
async def Prof(callback_query: types.CallbackQuery):
    await bot.delete_message(callback_query.from_user.id, callback_query.message.message_id)
    if callback_query.message.chat.type == 'private':
        user_name = callback_query.from_user.first_name
        user_last_name = callback_query.from_user.last_name
        user_id = callback_query.from_user.id
        # referals_count = db1.count_referals(user_id)  # предполагается, что функция принимает user_id
        full_name = f'{user_name} {user_last_name}' if user_last_name else user_name
        await bot.send_message(callback_query.from_user.id,
                               f'👤 {full_name}\n\nВаш ID: {callback_query.from_user.id}\nВаша реферальная ссылка 🎁: https://t.me/{cf.BOT_NAME}?start={callback_query.from_user.id}\n\nКол-во рефералов: referals_count',
                               reply_markup=krb.Back)


@dp.callback_query_handler(lambda query: query.data == 'back')
async def Back(callback_query: types.CallbackQuery):
    await bot.delete_message(callback_query.from_user.id, callback_query.message.message_id)
    await bot.send_message(callback_query.from_user.id, "Главное меню", reply_markup=krb.create_keyboard(user_id))


@dp.callback_query_handler(lambda query: query.data == 'add')
async def More(callback_query: types.CallbackQuery):
    # Сначала просим ввести Username
    await bot.send_message(callback_query.from_user.id, "Введите Username", reply_markup=krb.Back)
    await asyncio.sleep(2)

    # Просим ввести User_ID
    await bot.send_message(callback_query.from_user.id, "Введите User_ID", reply_markup=krb.Back)
    await asyncio.sleep(2)

    @dp.message_handler(content_types=types.ContentTypes.TEXT)
    async def handle_channel_link(message: types.Message):
        channel_link = message.text

        if not channel_link:
            await message.answer("Пожалуйста, пришлите ссылку на канал.")
            return

        try:
            # Получаем информацию о канале по ссылке
            chat = await bot.get_chat(channel_link)

            # Проверяем, состоит ли пользователь в канале
            user_id = message.from_user.id
            chat_member = await bot.get_chat_member(chat_id=chat.id, user_id=user_id)

            if chat_member.status != 'left':
                await message.answer(f"Вы подписаны на канал {chat.title}!")
            else:
                await message.answer(f"Вы не подписаны на канал {chat.title}.")
        except ChatNotFound:
            await message.answer("Канал не найден. Убедитесь, что ссылка правильная и бот имеет доступ.")
        except BadRequest:
            await message.answer("Ошибка. Возможно, бот не имеет доступа к этому каналу.")
        except Exception as e:
            await message.answer(f"Произошла ошибка: {e}")

# def get_all_user_ids():
#     # Пример: возвращаем список user_id из базы данных
#     return db1.get_all_user_ids()


# Функция для получения количества реакций на посте
async def get_reactions_count(post_url):
    # Здесь должен быть код для получения количества реакций на посте
    # Например, с помощью web scraping или API Telegram
    return await reaction(0)  # Пример: возвращаем количество реакций


# @dp.channel_post_handler()
# async def channel_message(message: types.Message):
#     # Когда в канале появляется новое сообщение, оно будет обрабатываться здесь
#     reactions = await reaction(1)
#     user_id1 = db1.get_random_user_id()
#     db1.update_user_score(user_id1, reactions * 50)
#     print(f"Saving to DB")
#
#     # Отправляем сообщение пользователю
#     try:
#         await bot.send_message(user_id1, f"Вы выиграли {reactions * 50} баллов!")
#     except Exception as e:
#         print(f"Не удалось отправить сообщение пользователю {user_id1}: {e}")
#
#     # Создаем кнопки с url и callback_data
#     post_url = f"https://t.me/mvp1test"
#     keyboard = InlineKeyboardMarkup().add(
#         InlineKeyboardButton("Перейти к посту", url=post_url),
#         InlineKeyboardButton("Получить баллы", callback_data=f"goto_post:{message.message_id}")
#     )
#
#     # Получаем все user_id пользователей
#     user_ids = get_all_user_ids()
#
#     # Отправляем сообщение с кнопками каждому пользователю
#     for user_id in user_ids:
#         try:
#             await bot.send_message(user_id, "Новый пост в канале!", reply_markup=keyboard)
#         except Exception as e:
#             print(f"Не удалось отправить сообщение пользователю {user_id}: {e}")


@dp.callback_query_handler(lambda c: c.data and c.data.startswith('goto_post'))
async def process_goto_post(callback_query: types.CallbackQuery):
    user_id = callback_query.from_user.id
    message_id = callback_query.data.split(':')[1]
    post_url = f"https://t.me/mvp1test"
    initial_reactions = await get_reactions_count(post_url)

    await asyncio.sleep(10)  # Ждем 10 секунд

    final_reactions = await get_reactions_count(post_url)

    try:
        if final_reactions > initial_reactions:
            db1.update_user_score(user_id, 50)
            await bot.answer_callback_query(callback_query.id, "Вы получили 50 баллов!")
            await bot.send_message(callback_query.message.chat.id,
                                   f"Пользователь {callback_query.from_user.username} получил 50 баллов!")
        else:
            await bot.answer_callback_query(callback_query.id, "Количество реакций не изменилось.")
            await bot.send_message(callback_query.message.chat.id, "Количество реакций не изменилось.")
    except Exception as e:
        print(f"Ошибка при обработке callback_query: {e}")


if __name__ == '__main__':
    try:
        executor.start_polling(dp, on_startup=on_startup, skip_updates=True)
    except:
        pass
