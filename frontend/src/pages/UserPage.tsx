import { useContext, useEffect, useState } from "react";
import PrizeProps from "../models/PrizeProps";
import { PrizesApiUrl } from "../api_links";
import UserProps from "../models/UserProps";
import { UserContext } from "../components/UserContext";
import Header from "../layout/Header";

const UserPage = () => {
  const userData = useContext<UserProps | undefined>(UserContext);
  const [prizeData, setPrizeData] = useState<PrizeProps[]>();
  let isIgnore = false;
  
  useEffect(() => {
    const fetchData = async () => {
      try {
        if (!isIgnore) {
              isIgnore = true;
              const response = await fetch(`${PrizesApiUrl}/winner/${userData?.userId}`);
              const data = await response.json();
              setPrizeData(data);
              console.log(data);
          }
        } catch (error) {
            console.error("fetch prizes by user error,", error);
        }
    }
    fetchData();
  }, []);


  return (
    <>
    <Header/>
    <div className="list">
      {prizeData?.map((prize, index) => (
        <div className="item" key={index}>
          <div className="item-text">
            <p className="point-text">{prize.cost}</p>
            <p>{prize.name}</p>
          </div>
          <div className="img-check"></div>
        </div>
      ))}
      </div>
    </>
  )
}

export default UserPage