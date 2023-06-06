import React from "react";
import "./Modal.css";
// import CloseIcon from "../../assets/closeIcon";

function Modal({ isVisible, children }) {
  if (!isVisible) return null;
  return (
    <div className={"modal"} id="modal">
      <div className={"modalBody"}>
        <div className="modalContent">{children}</div>
      </div>
    </div>
  );
}
export default Modal;
