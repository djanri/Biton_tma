
import { createContext } from "react";
import UserProps from "../models/UserProps";

export const UserContext = createContext<UserProps | undefined>({});