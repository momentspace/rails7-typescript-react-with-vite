import { Outlet } from "react-router-dom";

export function Root() {
  return (
    <>
      <div>test</div>
      <Outlet />
    </>
  );
};