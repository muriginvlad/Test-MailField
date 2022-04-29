# Описание - MailField

### Goal
Typing in email addresses on mobile devices is error prone, and time consuming.  The goal here is to reduce typos, mistakes, and save time entering addresses by using autocomplete and validation.

### Objective
Your objective is to build an incredible experience for users entering a single email address into a text field, while at the same time impressing us with how simple and clean your code is.

We receive many submissions daily, yours needs to stand out.  We're easily impressed by quality user interface, short & simple code.

### Requirements
- Email format validation
  - Example: "alex@gmail" is not a valid email
  - The user interface should indicate whether or not the email address is valid
  - Where appropriate the interface should indicate what is wrong with the address
- Email deliverability validation
  - Users often typo an address, for example wrong domain name (gmail.con vs gmail.com), or just mis type it
  - Use an existing API to confirm the email address can be delivered to, we recommend getting a free account at kickbox.io, and using their API
  - Where appropriate the interface should indicate what is wrong
- Autocomplete domain names
  - Typing email addresses is a pain, wouldn't it be nice if we didn't have to type the whole thing in?
  - We have observed that most email addresses end in popular domain names such as gmail.com, yahoo.com
  - Your autocomplete should suggest likely domain names and complete addresses
    - For example if the user types "alex@" we'd expect suggestions based on most popular domains, say "alex@gmail.com", "alex@yahoo.com", ...
    - If the user refines and types "alex@g" we'd expect suggestions based on popular domains beginning with g eg "alex@gmail.com", "alex@gmail.co.uk", ...
