import { useState } from 'react'
import { onLogin } from '../api/auth'
import Layout from '../components/layout'
import { useDispatch } from 'react-redux'
import { authenticateUser } from '../redux/slices/authSlice'
import "../styles/login.css";

const Login = () => {
  const [values, setValues] = useState({
    email: '',
    password: '',
  })
  const [error, setError] = useState(false)

  const onChange = (e) => {
    setValues({ ...values, [e.target.name]: e.target.value })
  }

  const dispatch = useDispatch()
  const onSubmit = async (e) => {
    e.preventDefault()

    try {
      await onLogin(values)
      dispatch(authenticateUser())

      localStorage.setItem('isAuth', 'true')
    } catch (error) {
      console.log(error.response.data.errors[0].msg)
      setError(error.response.data.errors[0].msg)
    }
  }

  return (
    <div className = "alter-body">
      <Layout>
        <div className = "login-main">
          <div className = "login-input">
            <form onSubmit={(e) => onSubmit(e)} className='container mt-3'>
              <h3>Login</h3>

              <div className='mb-3'>
                <label htmlFor='email' className='form-label'>
                  Email address
                </label>
                <input
                  onChange={(e) => onChange(e)}
                  type='email'
                  className='form-control'
                  id='email'
                  name='email'
                  value={values.email}
                  //placeholder='youremail@gmail.com'
                  required
                />
              </div>

              <div className='mb-3'>
                <label htmlFor='password' className='form-label'>
                  Password
                </label>
                <input
                  onChange={(e) => onChange(e)}
                  type='password'
                  value={values.password}
                  className='form-control'
                  id='password'
                  name='password'
                  //placeholder='passwod'
                  required
                />
              </div>

              <div style={{ color: 'red', margin: '10px 0' }}>{error}</div>

              <button type='submit' className='button-29'>
                Submit
              </button>
            </form>
          </div>
        </div>
      </Layout>
    </div>
  )
}

export default Login;