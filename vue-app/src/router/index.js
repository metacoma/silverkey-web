import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/components/Index'
import Download from '@/components/Download'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index
    },
    {
      path: '/download',
      name: 'Download',
      component: Download
    }
  ]
})
