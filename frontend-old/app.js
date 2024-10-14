// var proxy = require('express-http-proxy');
const express = require('express');
// const apiClient = require('./api-client.js'); // Подключение к модулю базы данных
const path = require('path');
const app = express();
const port = 3000;

if ("development" == app.get("env")) {
  process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
}

// app.use('/users', proxy('localhost:7000', {
//   https: true,
// }));

// Middleware для парсинга JSON
app.use(express.json());

// Маршрут для получения баллов пользователя по его ID
app.post('/update-points', (req, res) => {
  const userId = req.body.userId;
  const pointsToAdd = 100;

  // Сначала получаем текущие баллы пользователя
  apiClient.getUserPointsById(userId, (err, currentPoints) => {
    if (err) {
      console.error('Ошибка при получении баллов пользователя:', err.message);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      const newPoints = currentPoints + pointsToAdd;

      // Обновляем баллы пользователя
      // apiClient.updateUserPoints(userId, newPoints, (err) => {
      //   if (err) {
      //     console.error('Ошибка при обновлении баллов пользователя:', err.message);
      //     res.status(500).json({ error: 'Internal Server Error' });
      //   } else {
      //     console.log(`Баллы пользователя ${userId} успешно обновлены. Текущие баллы: ${newPoints}`);
      //     res.json({ success: true, points: newPoints });
      //   }
      // });
    }
  });
});



// Маршрут для получения списка призов
app.get('/prizes', (req, res) => {
  console.log('Запрос на получение списка призов');
  // apiClient.getPrizes((err, prizes) => {
  //   if (err) {
  //     console.error('Ошибка при получении списка призов:', err.message);
  //     res.status(500).json({ error: 'Internal Server Error' });
  //   } else {
  //     console.log(`Список призов: ${JSON.stringify(prizes)}`);
  //     res.json({ prizes });
  //     res.json({ prizes });
  //   }
  // });
});

// Маршрут для обработки покупки приза
app.post('/buyPrize', (req, res) => {
  const { userId, prizeId } = req.body;
  console.log(`Запрос на покупку приза: userId=${userId}, prizeId=${prizeId}`);
  // apiClient.getUserPointsById(userId, (err, points) => {
  //   if (err) {
  //     console.error('Ошибка при получении баллов пользователя:', err.message);
  //     res.status(500).json({ error: 'Internal Server Error' });
  //   } else {
  //     console.log(`Баллы пользователя ${userId} перед покупкой: ${points}`);
  //     apiClient.getPrizes((err, prizes) => {
  //       if (err) {
  //         console.error('Ошибка при получении списка призов:', err.message);
  //         res.status(500).json({ error: 'Internal Server Error' });
  //       } else {
  //         const prize = prizes.find(p => p.id === prizeId);
  //         if (prize && points >= prize.cost) {
  //           const newPoints = points - prize.cost;
  //           apiClient.updateUserPoints(userId, newPoints, (err) => {
  //             if (err) {
  //               console.error('Ошибка при обновлении баллов пользователя:', err.message);
  //               res.status(500).json({ error: 'Internal Server Error' });
  //             } else {
  //               console.log(`Приз успешно куплен: userId=${userId}, prizeId=${prizeId}, newPoints=${newPoints}`);
  //               res.json({ message: 'Prize purchased successfully', newPoints });
  //             }
  //           });
  //         } else {
  //           console.log(`Недостаточно баллов или неверный приз: userId=${userId}, prizeId=${prizeId}, points=${points}`);
  //           res.status(400).json({ error: 'Insufficient points or invalid prize' });
  //         }
  //       }
  //     });
  //   }
  // });
});

// Маршрут для получения баллов пользователя по его ID
app.get('/points/:userId', async (req, res) => {
  const userId = req.params.userId;

  const response = await fetch(`https://localhost:7000/users/${userId}`);
  const user = await response.json();
  res.json({ points: user.points });
});

// Обслуживание статических файлов
app.use(express.static(path.join(__dirname, 'public')));


// Запуск сервера
app.listen(port, (err) => {
  if (err) {
    console.error('Error starting server:', err);
  } else {
    console.log(`Server is running on http://localhost:${port}`);
  }
});
