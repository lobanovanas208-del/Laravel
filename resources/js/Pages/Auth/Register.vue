<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Регистрация" />

        <div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
            <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-xl">
                <!-- Заголовок -->
                <div class="text-center">
                    <h2 class="text-3xl font-extrabold text-gray-900">Создание аккаунта</h2>
                    <p class="mt-2 text-sm text-gray-600">
                        Заполните поля для регистрации
                    </p>
                </div>

                <form @submit.prevent="submit" class="mt-8 space-y-6">
                    <!-- Имя -->
                    <div class="space-y-1">
                        <InputLabel for="name" value="Имя" />
                        <TextInput
                            id="name"
                            type="text"
                            class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                            v-model="form.name"
                            required
                            autofocus
                            autocomplete="name"
                            placeholder="Ваше имя"
                        />
                        <InputError class="mt-1" :message="form.errors.name" />
                    </div>

                    <!-- Email -->
                    <div class="space-y-1">
                        <InputLabel for="email" value="Email" />
                        <TextInput
                            id="email"
                            type="email"
                            class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                            v-model="form.email"
                            required
                            autocomplete="username"
                            placeholder="example@mail.ru"
                        />
                        <InputError class="mt-1" :message="form.errors.email" />
                    </div>

                    <!-- Пароль -->
                    <div class="space-y-1">
                        <InputLabel for="password" value="Пароль" />
                        <TextInput
                            id="password"
                            type="password"
                            class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                            v-model="form.password"
                            required
                            autocomplete="new-password"
                            placeholder="••••••••"
                        />
                        <InputError class="mt-1" :message="form.errors.password" />
                    </div>

                    <!-- Подтверждение пароля -->
                    <div class="space-y-1">
                        <InputLabel for="password_confirmation" value="Подтверждение пароля" />
                        <TextInput
                            id="password_confirmation"
                            type="password"
                            class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                            v-model="form.password_confirmation"
                            required
                            autocomplete="new-password"
                            placeholder="••••••••"
                        />
                        <InputError class="mt-1" :message="form.errors.password_confirmation" />
                    </div>

                    <!-- Кнопка и ссылка на вход -->
                    <div class="flex items-center justify-between">
                        <Link
                            :href="route('login')"
                            class="text-sm text-indigo-600 hover:text-indigo-500"
                        >
                            Уже есть аккаунт? Войти
                        </Link>

                        <PrimaryButton
                            class="py-2 px-4"
                            :class="{ 'opacity-50 cursor-not-allowed': form.processing }"
                            :disabled="form.processing"
                        >
                            Зарегистрироваться
                        </PrimaryButton>
                    </div>
                </form>
            </div>
        </div>
    </GuestLayout>
</template>