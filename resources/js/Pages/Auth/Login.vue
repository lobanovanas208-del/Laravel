<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    login: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Вход" />

        <div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
            <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-xl">
                <!-- Заголовок (без логотипа) -->
                <div class="text-center">
                    <h2 class="text-3xl font-extrabold text-gray-900">Вход в аккаунт</h2>
                    <p class="mt-2 text-sm text-gray-600">
                        Введите ваш логин и пароль
                    </p>
                </div>

                <!-- Статус (например, после сброса пароля) -->
                <div v-if="status" class="rounded-md bg-green-50 p-3">
                    <div class="text-sm text-green-700 text-center">{{ status }}</div>
                </div>

                <form @submit.prevent="submit" class="mt-8 space-y-6">
                    <!-- Логин -->
                    <div class="space-y-1">
                        <InputLabel for="login" value="Логин или email" />
                        <TextInput
                            id="login"
                            type="text"
                            class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                            v-model="form.login"
                            required
                            autofocus
                            autocomplete="username"
                            placeholder="Ваш логин или email"
                        />
                        <InputError class="mt-1" :message="form.errors.login" />
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
                            autocomplete="current-password"
                            placeholder="••••••••"
                        />
                        <InputError class="mt-1" :message="form.errors.password" />
                    </div>

                    <!-- Запомнить меня и забыли пароль -->
                    <div class="flex items-center justify-between">
                        <label class="flex items-center">
                            <Checkbox name="remember" v-model:checked="form.remember" />
                            <span class="ml-2 text-sm text-gray-600">Запомнить меня</span>
                        </label>
                        <Link
                            v-if="canResetPassword"
                            :href="route('password.request')"
                            class="text-sm text-indigo-600 hover:text-indigo-500"
                        >
                            Забыли пароль?
                        </Link>
                    </div>

                    <!-- Кнопка входа -->
                    <PrimaryButton
                        class="w-full flex justify-center py-2"
                        :class="{ 'opacity-50 cursor-not-allowed': form.processing }"
                        :disabled="form.processing"
                    >
                        Войти
                    </PrimaryButton>

                    <!-- Ссылка на регистрацию -->
                    <div class="text-center">
                        <p class="text-sm text-gray-600">
                            Нет аккаунта?
                            <Link :href="route('register')" class="font-medium text-indigo-600 hover:text-indigo-500">
                                Зарегистрироваться
                            </Link>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </GuestLayout>
</template>