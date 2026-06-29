<template>
    <div class="min-h-screen bg-gray-100">
        <!-- Шапка с навигацией -->
        <header class="bg-white shadow">
            <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8 flex justify-between items-center">
                <h1 class="text-3xl font-bold text-gray-900">Музей истории</h1>
                <nav class="space-x-4">
                    <Link :href="route('exhibits')" class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium">
                        Экспонаты
                    </Link>
                    <Link :href="route('tours')" class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium">
                        Виртуальные экскурсии
                    </Link>
                    <Link :href="route('tickets')" class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium">
                        Купить билет
                    </Link>
                    <!-- Если пользователь авторизован, показываем Дашборд и Выход -->
                    <template v-if="$page.props.auth.user">
                        <Link :href="route('dashboard')" class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium">
                            Мой кабинет
                        </Link>
                        <button @click="logout" class="text-gray-700 hover:text-red-600 px-3 py-2 rounded-md text-sm font-medium">
                            Выйти
                        </button>
                    </template>
                    <template v-else>
                        <Link :href="route('login')" class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium">
                            Войти
                        </Link>
                        <Link :href="route('register')" class="text-gray-700 hover:text-indigo-600 px-3 py-2 rounded-md text-sm font-medium">
                            Регистрация
                        </Link>
                    </template>
                </nav>
            </div>
        </header>

        <!-- Основной контент -->
        <main>
            <div class="max-w-7xl mx-auto py-12 sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <div class="p-6 lg:p-8 bg-white border-b border-gray-200">
                        <div class="text-center">
                            <h2 class="text-4xl font-extrabold text-gray-900 mb-4">
                                Добро пожаловать в Музей истории
                            </h2>
                            <p class="text-xl text-gray-600 mb-8">
                                Погрузитесь в прошлое с нашими виртуальными экскурсиями
                            </p>
                            <Link :href="route('tours')" class="inline-flex items-center px-6 py-3 bg-indigo-600 border border-transparent rounded-md font-semibold text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Начать путешествие
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</template>

<script setup>
import { router, Link } from '@inertiajs/vue3';

const logout = () => {
    router.post(route('logout'));
};
</script>