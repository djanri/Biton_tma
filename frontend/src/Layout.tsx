import { Outlet } from "react-router-dom"
import Footer from "./components/footer"

const Layout = () => {
    return (
        <>
            <Outlet/>
            <Footer />
        </>
    )
  }
  
  export default Layout