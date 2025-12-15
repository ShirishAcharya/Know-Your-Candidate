import axios from "axios";

axios.defaults.withCredentials = true;
axios.defaults.baseURL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

export {};