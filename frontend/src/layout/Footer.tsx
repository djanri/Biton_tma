import { useLocation, useNavigate } from "react-router";
import PageUrl from "../components/PageUrl"

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
                className="footer-item user" />
            <input onChange={() => handleMouseEvent(PageUrl.Prizes)}
                type="radio"
                name="menu"
                checked={location.pathname == PageUrl.Prizes}
                className="footer-item prize"/>
            <input onChange={() => handleMouseEvent(PageUrl.Channels)}
                type="radio"
                name="menu"
                checked={location.pathname == PageUrl.Channels}
                className="footer-item channel"/>
      </footer>
    )
  }
  
  export default Footer