import { useEffect, useState } from "react";
import ChannelProps from "../models/ChannelProps";
import { ChannelsApiUrl } from "../api_links";

const ChannelsPage = () => {
  const [channelData, setChannelData] = useState<ChannelProps[]>();
  let isIgnore = false;
  
  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      if (!isIgnore) {
        isIgnore = true;
        const response = await fetch(`${ChannelsApiUrl}/`);
        const data = await response.json();
        setChannelData(data);
        console.log(data);
      }
    } catch (error) {
        console.error("fetch channels error,", error);
    }
  }

  return (
    <div className="list">
      {channelData?.map((channel, index) => (
        <div className="item border" key={index}>
          <p><b>{channel.name}</b></p>
          <p>{channel.url}</p>
        </div>
      ))}
    </div>
  );
}

export default ChannelsPage