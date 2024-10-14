import { useState } from 'react'
import { BrowserRouter, createBrowserRouter, createRoutesFromElements, Route, RouterProvider, Routes } from 'react-router-dom'
import Footer from './components/footer'
import UserPage from './pages/UserPage'
import PrizesPage from './pages/PrizesPage'
import ChannelsPage from './pages/ChannelsPage'
import PageUrl from './components/PageUrl'
import Layout from './Layout'

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path={PageUrl.User} element={<Layout/>}>
      <Route index element={<UserPage />} />
      <Route path={PageUrl.Prizes} element={<PrizesPage />} />
      <Route path={PageUrl.Channels} element={<ChannelsPage />} />
    </Route>
  )
)

function App() {

  return (
    <>
      <RouterProvider router={router}/>
    </>
  )
}

export default App
