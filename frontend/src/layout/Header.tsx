import { useContext } from "react";
import UserProps from "../models/UserProps";
import { UserContext } from "../components/UserContext";

const Header = () => {
    const userData = useContext<UserProps | undefined>(UserContext);
    return (
        <header>
            <h2 className="balance-title">Мой баланс: </h2>
            <h2 className="balance">{userData?.points}</h2>
            <div className="welcome">Привет, @{userData?.userName}</div>
            <div className="history">моя история покупок</div>
        </header>
    );
}

export default Header