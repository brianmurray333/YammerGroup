import React, { useState } from "react";
import Modal from "../components/Modals/Modal";
import AffinityForm from "../components/AffinityForm";
import CloseIcon from "../assets/closeIcon";

function Home() {
  const [showModal,setShowModal] = useState(true)
  const onClose = () => {
    alert("close modal");
    setShowModal(false)
  };

  return (
    <div>
      <Modal isVisible={showModal} onClose={onClose}>
        <div>
        <div className="affinityForm__heading">
          <div className="affinityForm__title">Create List </div>
          <div style={{cursor:"pointer"}} onClick={onClose}>
          <CloseIcon  />
          </div>
        </div>
        <hr />
        <AffinityForm />
        </div>
      </Modal>
    </div>
  );
}

export default Home;
