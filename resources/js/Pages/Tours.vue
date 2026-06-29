<template>
  <div class="min-h-screen bg-gray-100 py-10">

    <div class="max-w-6xl mx-auto px-6">

      <h1 class="text-3xl font-bold text-gray-800 mb-8">
        Виртуальные экскурсии
      </h1>

      <!-- Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

        <div
          v-for="tour in tours"
          :key="tour.id"
          class="bg-white rounded-2xl shadow hover:shadow-lg transition p-5 flex flex-col justify-between"
        >

          <!-- Title -->
          <h2 class="text-lg font-semibold text-gray-800 mb-3">
            {{ tour.title }}
          </h2>

          <!-- Fake description (если нет в базе) -->
          <p class="text-sm text-gray-500 mb-6">
            Погрузитесь в уникальную виртуальную экскурсию
          </p>

          <!-- Button -->
          <button
            @click="buyTour(tour.id)"
            class="mt-auto bg-indigo-600 hover:bg-indigo-700 text-white py-2 px-4 rounded-lg transition"
          >
            Купить билет
          </button>

        </div>

      </div>

    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { router } from '@inertiajs/vue3';

const tours = ref([
  { id: 1, title: 'Космическое путешествие' },
  { id: 2, title: 'Тайны древнего Египта' },
  { id: 3, title: 'Затерянный мир динозавров' },
  { id: 4, title: 'Путешествие по Байкалу' },
  { id: 5, title: 'Мастерская средневекового кузнеца' },
  { id: 6, title: 'Тур по Эрмитажу: главные шедевры' },
  { id: 7, title: 'Марс: колония будущего' },
  { id: 8, title: 'Секреты подводного мира (Большой Барьерный риф)' },
  { id: 9, title: 'Путешествие в сердце Тибета' },
  { id: 10, title: 'Архитектурный тур: небоскрёбы Нью-Йорка' }
]);

function buyTour(tourId) {
  router.visit('/tickets', { data: { tour_id: tourId } });
}
</script>