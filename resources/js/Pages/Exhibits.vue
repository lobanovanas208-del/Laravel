<template>
  <div class="min-h-screen bg-gray-100 py-10">

    <div class="max-w-6xl mx-auto px-6">

      <h1 class="text-3xl font-bold text-gray-800 mb-8">
        Каталог экспонатов
      </h1>

      <!-- Grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">

        <div
          v-for="item in exhibits"
          :key="item.id"
          class="bg-white rounded-2xl shadow hover:shadow-lg transition p-5 flex items-center justify-between"
        >

          <div class="flex items-center gap-3">
            <div class="w-10 h-10 bg-indigo-100 rounded-full flex items-center justify-center">
              
            </div>

            <span class="text-gray-800 font-medium">
              {{ item.name }}
            </span>
          </div>

        </div>

      </div>

    </div>

  </div>
</template>

<script setup>
import { ref } from 'vue'

const exhibits = ref([
  { id: 1, name: 'Древний меч' },
  { id: 2, name: 'Старинная карта' }
])
</script>