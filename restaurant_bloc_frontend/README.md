🍽️ Restaurante App - Flutter + Node.js + MongoDB
Aplicación móvil de restaurante construida con Flutter como frontend, Node.js para el backend, y MongoDB como base de datos. Permite a los usuarios explorar menús, y hacer pedidos de forma eficiente.

🚀 Características principales
📱 App móvil intuitiva hecha con Flutter.

🔐 Autenticación de usuarios (registro, login, OTP por correo).

🍔 Explora categorías y productos del menú.

🛒 Sistema de carrito y pedidos.

💳 Integración de pagos (Stripe / PayPal).

🧱 Tecnologías
Frontend (Flutter)
Flutter 3.x

Provider / BLoC

Backend (Node.js + Express)
Express.js

JWT para autenticación

Nodemailer para envío de OTP

Stripe / PayPal SDK

MongoDB con Mongoose

🗂️ Estructura del proyecto

/restaurant_bloc_back         -> Servidor Node.js con rutas REST
/restaurant_bloc_frontend      -> App Flutter (iOS y Android)

⚙️ Instalación rápida
cd restaurant_bloc_back
pnpm install
pnpm run dev

Flutter App
cd restaurant_bloc_frontend
flutter pub get
