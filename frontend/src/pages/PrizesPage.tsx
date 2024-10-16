import { useEffect, useState } from "react";
import { PrizesApiUrl } from "../api_links";
import PrizeProps from "../models/PrizeProps";

const PrizesPage = () => {
  const [prizeData, setPrizeData] = useState<PrizeProps[]>();
  let isIgnore = false;
  const userId = 1;
  
  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      if (!isIgnore) {
            isIgnore = true;
            const response = await fetch(`${PrizesApiUrl}/active`);
            const data = await response.json();
            setPrizeData(data);
            console.log(data);
        }
      } catch (error) {
          console.error("fetch prizes by user error,", error);
      }
  }

  const buyClick = async (prize: PrizeProps) => {
    console.log("click");
    prize.userId = userId;
    const settings = {
      method: 'PUT',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(prize)
    };
    
    try {
      const response = await fetch(`${PrizesApiUrl}/${prize.id}`, settings);
      if (response.ok) {
        fetchData();
      }
    } catch (e) {
      console.error("buy prize by user error,", e);
    }
  }

  return (
    <div className="list">
      {prizeData?.map((prize, index) => (
        <div className="item border" key={index}>
          <p><b>{prize.name}</b></p>
          <p>{prize.description}</p>
          <p>Цена: {prize.cost} поинтов</p>
          <button onClick={() => buyClick(prize)}>Купить</button>
        </div>
    ))}
    </div>
  )
}

export default PrizesPage