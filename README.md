# ✅ Checklist App - CSC 680 Final Project

## 👥 Team Members(Student ID)
- Ting Feng (922992561)
- Hugo Gomez (921810640)
- Jacob Torres  (921890447)
- Yonatan Leake  (918695705)  

## 📱 Project Description
The **Checklist App** is a productivity application that helps users organize tasks efficiently. It enables users to create, manage, and track completion of checklist items with **local data persistence**. The app demonstrates core iOS development competencies including:

- SwiftUI framework  
- MVVM architecture  
- Local data persistence (UserDefaults/CoreData)  
- Multi-screen navigation  
- State management  

## 🎯 Project Goals
- Build a functional, polished app to showcase in professional portfolios  
- Demonstrate mastery of iOS development concepts covered in class  
- Solve a real productivity problem with clean, maintainable code  
- Implement best practices in UI/UX design  

## ✅ Must-Have Features
- [X] Create and manage multiple checklists  
- [X] Add/edit/delete checklist items  
- [X] Mark items as complete/incomplete  
- [X] Data persistence using CoreData  
- [X] Clean, intuitive UI with smooth animations  

## ✨ Nice-to-Have Features
- [X] Due Dates & Sorting  
- [X] Dark/Light mode toggle (Works with Apple Dark/Light mode setting)
- [] Checklist sharing functionality  
- [X] Reorder items (Did this with sorting) 
- [] Custom checklist background colors
- [X] Checklist emoji customization
- [X] Help Guide
- [X] Progress bar

## 🛠️ Technology Stack
- Swift  
- SwiftUI  
- CoreData  
- Xcode 16+  
- iOS 18+  

## 📊 Milestone Progress

### Milestone 1: Project Setup *(Complete)*
- [x] GitHub repository created  
- [x] Project proposal finalized  
- [X] Wireframes created (Located in Checklist App/Checklist App/Views/Wireframes in Xcode to see them)  
- [X] Development environment configured  

### Milestone 2: Prototype *(Complete)*
- [X] CoreData model implemented  
- [X] Basic UI for all must-have features  
- [X] ViewModel architecture established  
- [X] Data persistence working  

### Milestone 3: Final Submission
- [X] All must-have features implemented  
- [X] Code review and optimization  
- [X] Final testing and bug fixes  
- [X] Possible in-class presentation  
- [X] Documentation completed  

## 🎨 Wireframes
![Main Screen](wireframes/main.png)  
*Home screen showing all checklists*

![Detail View](wireframes/detail.png)  
*Checklist items with completion toggle*

![Add Item](wireframes/add.png)  
*Form for adding new items*

## ⏱️ Time Estimates & Progress Tracking

| Feature                  | Estimated Time | Actual Time | Status       |
|--------------------------|----------------|-------------|--------------|
| CoreData Model Setup     | 3 hours        | 3 hours     | Done         |
| Main Checklist View      | 4 hours        | 3 hours     | Done         |
| Item Management          | 3 hours        | 3 hours     | Done         |
| Data Persistence         | 3 hours        | 3 hours     | Done         |
| UI Polish & Animations   | 5 hours        | 5 hours     | Done         |
| Due Dates                | 2 hours        | 2 hours     | Done         |
| Misc features            | 4 hours        | 8 hours     | Done         |
| Group meetings and documentation          | 5 hours        | 10 hours     | Done         |



**Total Estimated Time:** 20~50 hours  
**Current Time Invested:** 40+ hours

## 🏗️ Technical Implementation

### Architecture
- **MVVM Pattern**: Separation of concerns between views and business logic  
- **ObservableObject**: ViewModels trigger UI updates  
- **CoreData**: Robust local storage solution  
- **Modular Components**: Reusable SwiftUI views  

### Key Components
- `ChecklistView`: Main screen displaying all checklists  
- `ChecklistDetailView`: Individual checklist management  
- `AddItemView`: Form for new items  
- `ChecklistViewModel`: Manages business logic and data  
- `PersistenceController`: Handles CoreData operations  
