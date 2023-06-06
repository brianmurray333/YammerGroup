import React from 'react'
import "./Button.css"

function PrimaryButton({title,onClick,disabled}) {
  return (
    <button onClick={onClick} disabled={disabled} className={ disabled ? "primary-btn-disabled":"primary-btn"}>{title}</button>
  )
}

export default PrimaryButton