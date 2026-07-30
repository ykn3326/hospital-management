document.addEventListener('DOMContentLoaded', function () {
  const passwordInput = document.querySelector('[name="password"]');
  const toggleButton = document.querySelector('.toggle-password');
  if (passwordInput && toggleButton) {
    toggleButton.addEventListener('click', function () {
      const isHidden = passwordInput.type === 'password';
      passwordInput.type = isHidden ? 'text' : 'password';
      toggleButton.innerText = isHidden ? 'Hide' : 'Show';
      passwordInput.focus();
    });
  }

  const roleSelect = document.querySelector('[name="role"]');
  const roleHint = document.querySelector('.role-hint');
  if (roleSelect && roleHint) {
    const hints = {
      patient: 'Use your patient email to track appointments, medical records and billing.',
      doctor: 'Login to manage your appointments, patient notes and prescriptions.',
      admin: 'Admin access gives you control over operations, staff and system settings.'
    };

    function updateRoleHint() {
      const role = roleSelect.value;
      roleHint.textContent = hints[role] || 'Select your account type to continue.';
    }

    roleSelect.addEventListener('change', updateRoleHint);
    updateRoleHint();
  }
});
