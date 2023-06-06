import React from 'react'
import "./Forms.css"

function TextInput({type,id,placeholder,width,setValue}) {
  return (
    <input onChange={(e)=>setValue(e.target.value)} style={{maxWidth:width}} className="text-input" placeholder={placeholder} type={type} id={id}  />
  ) 
}

export default TextInput