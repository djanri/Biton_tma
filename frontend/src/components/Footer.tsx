import { Outlet, useLocation, useNavigate } from "react-router";
import PageUrl from "./PageUrl"

const Footer = () => {
    const navigate = useNavigate();
    const location = useLocation();

    const handleMouseEvent = (url: PageUrl) => {
        navigate(url);
      };
    return (
        <footer>
            <input onChange={() => handleMouseEvent(PageUrl.User)}
                type="radio"
                name="menu"
                checked={location.pathname == PageUrl.User}
                className="footer-item" />
            <input onChange={() => handleMouseEvent(PageUrl.Prizes)}
                type="radio"
                name="menu"
                checked={location.pathname == PageUrl.Prizes}
                className="footer-item"/>
            <input onChange={() => handleMouseEvent(PageUrl.Channels)}
                type="radio"
                name="menu"
                checked={location.pathname == PageUrl.Channels}
                className="footer-item"/>
      </footer>
    )
  }
  
  export default Footer