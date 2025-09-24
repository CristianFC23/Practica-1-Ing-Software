import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/components/HomeView.vue'
import UbicacionesView from '@/components/UbicacionesView.vue'
import PersonalView from '@/components/PersonalView.vue'
import EquiposView from '@/components/EquiposView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/ubicacion',
    name: 'ubicacion',
    component: UbicacionesView
  },
  {
    path: '/personal',
    name: 'personal',
    component: PersonalView
  },
  {
    path: '/equipos',
    name: 'equipos',
    component: EquiposView
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
