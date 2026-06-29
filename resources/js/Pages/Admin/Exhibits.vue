<template>
  <div>
    <h1>Экспонаты (админ)</h1>

    <form @submit.prevent="create">
      <input v-model="name" placeholder="Название" />
      <button type="submit">Добавить</button>
    </form>

    <ul>
      <li v-for="item in exhibits" :key="item.id">
        {{ item.name }}
      </li>
    </ul>
  </div>


</template>

<script setup>
import { ref } from 'vue'
import { router } from '@inertiajs/vue3'

defineProps({
  exhibits: Array
})

const name = ref('')

function create() {
  router.post('/admin/exhibits', {
    name: name.value
  })
}
const logout = () => {
    router.post('/logout')
}
  users = [
  {
    id: 1,
    name: "John",
    email: "...",
    tickets_count: 5
  }
  ]
const form = useForm({
    login: '',
    password: '',
    remember: false,
});
</script>