
import { createContext } from "react";
import UserProps from "../models/UserProps";
import { useOutletContext } from "react-router-dom";

export const UserContext = createContext<UserProps | undefined>(undefined);

type EventContext = {
    onRefresh: () => void;
}

export const useEventContext = () => useOutletContext<EventContext>();