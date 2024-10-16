import { useEffect, useState } from "react";
import PrizeProps from "../models/PrizeProps";
import { PrizesApiUrl } from "../api_links";

const UserPage = () => {
  const [prizeData, setPrizeData] = useState<PrizeProps[]>();
  let isIgnore = false;
  useEffect(() => {
    const fetchData = async () => {
      try {
        if (!isIgnore) {
              isIgnore = true;
              const response = await fetch(`${PrizesApiUrl}/winner/1`);
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
    <div className="list">
      {prizeData?.map((prize, index) => (
        <p className="item" key={index}>{prize.name}</p>
      ))}
    </div>
  )
}

export default UserPage