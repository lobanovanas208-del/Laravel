<template>
  <div class="min-h-screen bg-gray-100 flex flex-col">

    <!-- Header -->
    <header class="bg-white shadow-md">
      <div class="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">

        <h1 class="text-2xl font-bold text-gray-800">
          🏛 Музей истории
        </h1>

        <button
          @click="logout"
          class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg transition"
        >
          Выйти
        </button>

      </div>
    </header>

    <!-- Navigation -->
    <nav class="bg-white border-b">
      <div class="max-w-6xl mx-auto px-6 py-3 flex gap-6">

        <a href="/exhibits"
           class="text-gray-700 hover:text-indigo-600 font-medium transition">
          Экспонаты
        </a>

        <a href="/tours"
           class="text-gray-700 hover:text-indigo-600 font-medium transition">
          Виртуальные экскурсии
        </a>

        <a href="/tickets"
           class="text-gray-700 hover:text-indigo-600 font-medium transition">
          Купить билет
        </a>

      </div>
    </nav>

    <!-- Content placeholder -->
    <main class="flex-1 max-w-6xl mx-auto px-6 py-10">
      <div class="bg-white rounded-2xl shadow p-6 text-gray-700">
        Добро пожаловать в музей 👋
      </div>
    </main>

  </div>
</template>

<script setup>
import { router } from '@inertiajs/vue3';

const logout = () => {
  router.post('/logout');
};
</script>