import { useEffect, useState } from "react";
import UserProps from "../models/UserProps";
import { UsersApiUrl } from "../api_links";

const Header = () => {
    const [userData, setUserData] = useState<UserProps>();

    useEffect(() => {
        fetchUserData();
    }, []);

    const fetchUserData = async () => {
        try {
            const response = await fetch(`${UsersApiUrl}/1`);
            const data = await response.json();
            setUserData(data);
            console.log(data);
        } catch (error) {
            console.error("fetch users error,", error);
        }
        
    }

    return (
        <header>
            <p className="balance">Баланс <span>{userData?.points}</span> поинтов</p>
            <h2 className="welcome">Добро пожаловать <span>{userData?.userName}</span></h2>
        </header>
    );
}

export default Header