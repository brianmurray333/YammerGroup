import React from "react";
import "./Forms.css";

function TextAreaInput({ type, id, placeholder, setValue }) {
  return (
    <textarea
      onChange={(e) => setValue(e.target.value)}
      className="text-input"
      placeholder={placeholder}
      type={type}
      id={id}
    />
  );
}

export default TextAreaInput;
