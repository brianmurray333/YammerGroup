import React from 'react'
import "./Forms.css"

function TextAreaInput({type,id,placeholder}) {
  return (
    <textarea className="text-input"  placeholder={placeholder} type={type} id={id}  />
  ) 
}

export default TextAreaInput