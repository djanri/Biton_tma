import { createBrowserRouter, createRoutesFromElements, Route, RouterProvider } from 'react-router-dom'
import UserPage from './pages/UserPage'
import PrizesPage from './pages/PrizesPage'
import ChannelsPage from './pages/ChannelsPage'
import PageUrl from './components/PageUrl'
import Layout from './layout/Layout'

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
