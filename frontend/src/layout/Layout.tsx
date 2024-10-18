import { Outlet } from "react-router-dom"
import Footer from "./Footer"
import Header from "./Header"
import { UserContext } from "../components/UserContext"
import { useEffect, useState } from "react"
import UserProps from "../models/UserProps"
import { UsersApiUrl } from "../api_links"
import { initData, useSignal } from "@telegram-apps/sdk-solid"


const Layout = () => {
    const [userData, setUserData] = useState<UserProps>();
    const initTelegramData = useSignal(initData.state);
    let isIgnore = false;

    useEffect(() => {
        fetchUserData();
    }, []);

    
    const fetchUserData = async () => {
        try {
            if (!isIgnore) {
                isIgnore = true;
                const user = initTelegramData()?.user;
                const response = await fetch(`${UsersApiUrl}/${user?.id}`);
                const data = await response.json();
                setUserData(data);
                console.log(data);
            }
        } catch (error) {
            console.error("fetch users error,", error);
        }
    }
    

    return (
        userData == null
            ?
            <div>Not found user</div>
            :
        <UserContext.Provider value={userData}>
            
            <Outlet context={{ onRefresh: fetchUserData }}/>
            <Footer />
        </UserContext.Provider >
    )
  }
  
  export default Layout