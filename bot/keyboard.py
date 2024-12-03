from aiogram.types import InlineKeyboardMarkup, InlineKeyboardButton, WebAppInfo

def create_keyboard(user_id):
    # web_app_info = WebAppInfo(url=f'https://biton-tma.local?user_id={user_id}')
    web_app_info = WebAppInfo(url=f'https://gamefication.tw1.su?user_id={user_id}')
    glav = InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="Go to the app💡", web_app=web_app_info)],
        [InlineKeyboardButton(text="Подробнее о проекте ⁉️", callback_data='more')],
        [InlineKeyboardButton(text="Профиль👤", callback_data='profile')],
        [InlineKeyboardButton(text="Наш канал", url="https://t.me/studeventsmsk")],
    ])
    return glav


My_Chanel = InlineKeyboardMarkup(inline_keyboard=[
    [InlineKeyboardButton(text="Я подписался ️", callback_data='sub')],
    [InlineKeyboardButton(text="Subscribe to the channel", url="https://t.me/studeventsmsk")]
])


def cancel_keyboard():
    keyboard = InlineKeyboardMarkup().add(
        InlineKeyboardButton("Отмена", callback_data='cancel')
    )
    return keyboard
    
Back = InlineKeyboardMarkup(inline_keyboard=[
    [InlineKeyboardButton(text="Назад ️", callback_data='back')],

])

Super=  InlineKeyboardMarkup(inline_keyboard=[
    [InlineKeyboardButton(text="Добавить Админа", callback_data='add')],
    [InlineKeyboardButton(text="Удалить Админа", callback_data='remove')],
])