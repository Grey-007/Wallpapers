window {
    margin: 0px;
    padding: 0px;
    border-radius: 10px;
    border: 2px solid rgba(192, 20, 23, 0.9); /* bright red */
    background-color: #0a0a0a;
    color: #e0e0e0;
    font-family: "Fira Sans", "Iosevka Nerd Font", sans-serif;
    font-size: 12px;
}

/* Outer container */
#outer-box {
    padding: 10px 14px 12px 14px;
    background-color: #0a0a0a;
}

/* Hide input field for this menu */
#input {
    border: none;
    padding: 0;
    margin: 0;
    min-height: 0;
    background: transparent;
    color: transparent;
}

/* List area */
#scroll {
    margin-top: 2px;
}

/* Each entry (row) */
#entry {
    padding: 6px 10px;
    border-radius: 8px;
    background-color: transparent;
    color: #e0e0e0;

    /* Animation: smooth transition and tiny slide */
    transition:
        background-color 0.15s ease-out,
        color 0.15s ease-out,
        transform 0.12s ease-out,
        box-shadow 0.15s ease-out;
}

/* Hover animation (mouse over) */
#entry:hover {
    background-color: rgba(90, 10, 11, 0.8); /* dark red hover */
    transform: translateX(2px);              /* tiny slide to the right */
}

/* Selected entry (keyboard selection) */
#entry:selected {
    background-color: rgba(192, 20, 23, 0.95); /* bright red */
    color: #0a0a0a;

    /* Slight pop + subtle shadow */
    transform: translateX(3px);
    box-shadow: 0 0 6px rgba(192, 20, 23, 0.6);
}

/* Text inside the entry */
#text {
    margin-left: 4px;
}

/* Selected text slightly bolder */
#entry:selected #text {
    font-weight: 500;
}
#entry-icon {
    width: 16px;
    height: 16px;
    filter: invert(100%) sepia(0%) saturate(0%) hue-rotate(93deg) brightness(103%) contrast(103%);
}   
