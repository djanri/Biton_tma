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
            <div className="footer-item">
                <input onChange={() => handleMouseEvent(PageUrl.User)}
                    type="radio"
                    id="profile"
                    name="menu"
                    checked={location.pathname == PageUrl.User}/>
                <label htmlFor="profile">Профиль</label>
            </div>
            <div className="footer-item">
                <input onChange={() => handleMouseEvent(PageUrl.Prizes)}
                    type="radio"
                    id="prize"
                    name="menu"
                    checked={location.pathname == PageUrl.Prizes}/>
                <label htmlFor="prize">Призы 🪙</label>
            </div>
            <div className="footer-item">
                <input onChange={() => handleMouseEvent(PageUrl.Channels)}
                    type="radio"
                    id="point"
                    name="menu"
                    checked={location.pathname == PageUrl.Channels} />
                <label htmlFor="point">Больше баллов</label>
            </div>
      </footer>
    )
  }
  
  export default Footer