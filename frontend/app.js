const API_URL = 'http://localhost:8081/api/tasks';

document.addEventListener('DOMContentLoaded', fetchTasks);

document.getElementById('task-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const task = {
        title: document.getElementById('title').value,
        description: document.getElementById('description').value,
        status: document.getElementById('status').value
    };

    try {
        const response = await fetch(API_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(task)
        });
        if (response.ok) {
            document.getElementById('task-form').reset();
            fetchTasks();
        }
    } catch (error) {
        console.error('Error creating task:', error);
    }
});

async function fetchTasks() {
    const taskList = document.getElementById('task-list');
    taskList.innerHTML = '<div class="loader">Synchronizing...</div>';

    try {
        const response = await fetch(API_URL);
        const tasks = await response.json();
        
        taskList.innerHTML = '';
        tasks.forEach(task => {
            const card = document.createElement('div');
            card.className = 'task-card';
            card.innerHTML = `
                <h3>${task.title}</h3>
                <p>${task.description || 'No description provided.'}</p>
                <div class="status-badge ${task.status.replace(' ', '-')}">${task.status}</div>
                <div class="actions">
                    <button onclick="deleteTask(${task.id})" class="delete-btn">Delete</button>
                </div>
            `;
            taskList.appendChild(card);
        });
        
        if (tasks.length === 0) {
            taskList.innerHTML = '<p class="subtitle">No tasks found. Create one to get started!</p>';
        }
    } catch (error) {
        taskList.innerHTML = '<p style="color:red">Failed to connect to backend service.</p>';
        console.error('Error fetching tasks:', error);
    }
}

async function deleteTask(id) {
    if (confirm('Are you sure you want to remove this task?')) {
        try {
            await fetch(`${API_URL}/${id}`, { method: 'DELETE' });
            fetchTasks();
        } catch (error) {
            console.error('Error deleting task:', error);
        }
    }
}
