import { Outlet } from "react-router-dom"
import Footer from "./Footer"
import Header from "./Header"
import { UserContext } from "../components/UserContext"
import { useEffect, useState } from "react"
import UserProps from "../models/UserProps"
import { UsersApiUrl } from "../api_links"

const Layout = () => {
    const [userData, setUserData] = useState<UserProps>();

    let isIgnore = false;
    useEffect(() => {
        const fetchUserData = async () => {
            try {
                if (!isIgnore) {
                    isIgnore = true;
                    const response = await fetch(`${UsersApiUrl}/1`);
                    const data = await response.json();
                    setUserData(data);
                    console.log(data);
                }
            } catch (error) {
                console.error("fetch users error,", error);
            }
        }
        fetchUserData();
    }, []);

    

    return (
        <UserContext.Provider value={userData}>
            <Header/>
            <Outlet/>
            <Footer />
        </UserContext.Provider>
    )
  }
  
  export default Layout