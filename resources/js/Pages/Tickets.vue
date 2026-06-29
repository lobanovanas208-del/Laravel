<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center py-10">

    <div class="w-full max-w-lg bg-white rounded-2xl shadow-xl p-8">

      <h1 class="text-2xl font-bold text-gray-800 mb-6 text-center">
        Покупка билета
      </h1>

      <form @submit.prevent="buy" class="space-y-5">

        <!-- Tour select -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Выберите экскурсию
          </label>

          <select
            v-model="form.tour_id"
            required
            class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-500 focus:outline-none"
          >
            <option disabled value="">Выберите экскурсию</option>

            <option
              v-for="tour in tours"
              :key="tour.id"
              :value="tour.id"
            >
              {{ tour.title }} — {{ tour.price }} руб.
            </option>

          </select>
        </div>

        <!-- Name -->
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">
            Ваше имя
          </label>

          <input
            v-model="form.name"
            type="text"
            required
            placeholder="Введите имя"
            class="w-full border border-gray-300 rounded-lg p-2 focus:ring-2 focus:ring-indigo-500 focus:outline-none"
          />
        </div>

        <!-- Button -->
        <button
          type="submit"
          :disabled="form.processing"
          class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 rounded-lg transition disabled:opacity-50"
        >
          Купить билет
        </button>

      </form>

      <!-- Success -->
      <div
        v-if="$page.props.flash.success"
        class="mt-5 bg-green-100 text-green-700 p-3 rounded-lg text-center"
      >
        {{ $page.props.flash.success }}
      </div>

    </div>

  </div>
</template>

<script setup>
import { useForm } from '@inertiajs/vue3';

const props = defineProps({
  tours: Array,
  selectedTourId: { type: Number, default: null }
});

const form = useForm({
  name: '',
  tour_id: props.selectedTourId || '',
});

function buy() {
  form.post('/tickets/buy', {
    onSuccess: () => form.reset(),
  });
}
</script>