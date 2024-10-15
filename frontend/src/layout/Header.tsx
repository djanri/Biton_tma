import { useContext } from "react";
import UserProps from "../models/UserProps";
import { UserContext } from "../components/UserContext";

const Header = () => {
    const userData = useContext<UserProps | undefined>(UserContext);
    return (
        <header>
            <p className="balance">Баланс <span>{userData?.points}</span> поинтов</p>
            <h2 className="welcome">Добро пожаловать <span>{userData?.userName}</span></h2>
        </header>
    );
}

export default Header