<template>
    

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <!-- Карточки статистики -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-6">
                        <div class="text-sm font-medium text-gray-500">Пользователей</div>
                        <div class="text-3xl font-bold text-gray-900">{{ stats.totalUsers }}</div>
                    </div>
                    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-6">
                        <div class="text-sm font-medium text-gray-500">Продано билетов</div>
                        <div class="text-3xl font-bold text-gray-900">{{ stats.totalTickets }}</div>
                    </div>
                    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-6">
                        <div class="text-sm font-medium text-gray-500">Доступно туров</div>
                        <div class="text-3xl font-bold text-gray-900">{{ stats.totalTours }}</div>
                    </div>
                    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-6">
                        <div class="text-sm font-medium text-gray-500">Выручка</div>
                        <div class="text-3xl font-bold text-gray-900">{{ formatPrice(stats.totalRevenue) }}</div>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Последние продажи -->
                    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-900 mb-4">Последние покупки</h3>
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500">Пользователь</th>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500">Тур</th>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500">Цена</th>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500">Дата</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <tr v-for="ticket in recentTickets" :key="ticket.id">
                                        <td class="px-4 py-2 text-sm text-gray-900">{{ ticket.user_name }}</td>
                                        <td class="px-4 py-2 text-sm text-gray-900">{{ ticket.tour_title }}</td>
                                        <td class="px-4 py-2 text-sm text-gray-900">{{ formatPrice(ticket.price) }}</td>
                                        <td class="px-4 py-2 text-sm text-gray-500">{{ ticket.created_at }}</td>
                                    </tr>
                                    <tr v-if="recentTickets.length === 0">
                                        <td colspan="4" class="px-4 py-2 text-center text-gray-500">Нет покупок</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Популярные туры -->
                    <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                            <h3 class="text-lg font-semibold text-gray-900 mb-4">Популярные туры</h3>
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500">Название</th>
                                        <th class="px-4 py-2 text-left text-xs font-medium text-gray-500">Продано билетов</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200">
                                    <tr v-for="tour in popularTours" :key="tour.id">
                                        <td class="px-4 py-2 text-sm text-gray-900">{{ tour.title }}</td>
                                        <td class="px-4 py-2 text-sm text-gray-900">{{ tour.tickets_count }}</td>
                                    </tr>
                                    <tr v-if="popularTours.length === 0">
                                        <td colspan="2" class="px-4 py-2 text-center text-gray-500">Нет данных</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

</template>

<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';

defineProps({
    stats: Object,
    recentTickets: Array,
    popularTours: Array
});

function formatPrice(price) {
    return new Intl.NumberFormat('ru-RU', { style: 'currency', currency: 'RUB', minimumFractionDigits: 0 }).format(price);
}
</script>